<%@ include file="/html/init.jsp" %>
<liferay-ui:error key="emptyField" message="mandatory-fields-error" />
<liferay-ui:error key="numericExpected" message="numeric-error" />
<%
List<Task> tasks = (List<Task>)request.getAttribute("tasks");
String project = (String)request.getAttribute("project");
String finalEstimation= (String)request.getAttribute("finalEstimation");
String sumOfProbabilityDistributions= (String)request.getAttribute("sumOfProbabilityDistributions"); 

if(tasks==null){
    tasks= new ArrayList<Task>();
    tasks.add(new Task());
}

int[] taskFieldsIndexes =  new int[tasks.size()];
for (int i = 0; i < tasks.size(); i++) {
	taskFieldsIndexes[i] = i + 1;
}
%>
<liferay-portlet:actionURL var="calculateEstimationURL" name="calculateEstimation" windowState="<%= WindowState.NORMAL.toString() %>" />
<p>
	<b>*<%= LanguageUtil.get(pageContext, "optimistic-estimate") %>:</b> <%= LanguageUtil.get(pageContext, "optimistic-estimate-explanation") %> <br />
	<b>*<%= LanguageUtil.get(pageContext, "nominal-estimate") %>:</b> <%= LanguageUtil.get(pageContext, "nominal-estimate-explanation") %> <br />
	<b>*<%= LanguageUtil.get(pageContext, "pessimistic-estimate") %>:</b> <%= LanguageUtil.get(pageContext, "pessimistic-estimate-explanation") %><br />
</p>

<aui:form action="<%=calculateEstimationURL%>" method="post" name="fm">
	<aui:input name="project" value="<%=project%>" label="project" inlineLabel="left" type="text"/>
	<br />
	<aui:fieldset cssClass="rows-container tasks">	
		<table>
			<tr>
				  <th><%= LanguageUtil.get(pageContext, "task-name") %></th>
				  <th>*<%= LanguageUtil.get(pageContext, "optimistic-estimate") %></th>
				  <th>*<%= LanguageUtil.get(pageContext, "nominal-estimate")%></th>		  
				  <th>*<%= LanguageUtil.get(pageContext, "pessimistic-estimate") %></th>
				  <th><%= LanguageUtil.get(pageContext, "expected-duration") %></th>
				  <th><%= LanguageUtil.get(pageContext, "standard-deviation") %></th>
			</tr>
		<%
			for (int i = 0; i < taskFieldsIndexes.length; i++) {
				int taskFieldIndex = taskFieldsIndexes[i];
				Task task = new Task();
				if (tasks.size() > 0) {
				    task = tasks.get(i);
				}
		%>				
			<tr class="lfr-form-row" id="<portlet:namespace/>tasks">		
				<td>
					<aui:input name="<%=\"name\" + taskFieldIndex%>" value="<%=task.getName()%>" label="" type="textarea" size="16"/>
				</td>					
				<td>
					<aui:input name="<%=\"minEst\" + taskFieldIndex%>" value="<%=task.getMinEst()%>" label="" type="text" size="16"/>
				</td>					
				<td>
					<aui:input name="<%=\"nominalEst\" + taskFieldIndex%>" value="<%=task.getNomEst()%>" label="" type="text" size="16"/>
				</td>					
				<td>
					<aui:input name="<%=\"maxEst\" + taskFieldIndex%>" value="<%=task.getMaxEst()%>" label="" type="text" size="16"/>
				</td>				
				<td>
					<div class="tableData"><%=(task.getExpectedDuration()!=null)?task.getExpectedDuration():StringPool.BLANK %></div>					
				</td>				
				<td>
					<div class="tableData"><%=(task.getStandardDeviation()!=null)?task.getStandardDeviation():StringPool.BLANK%></div>		
				</td>
			</tr>				
		<%	}	%>
		</table>
	</aui:fieldset>
	
	<aui:button-row>
		<aui:button value="Calculate Estimation" onClick='<%= renderResponse.getNamespace() + "calculate();" %>' />
	</aui:button-row>

</aui:form>

<%
if(finalEstimation!=null){
    DecimalFormat doubleFormat=new DecimalFormat("#.##"); 
    String sumOfProbabilityDistributionsFormatted=doubleFormat.format(Double.parseDouble(sumOfProbabilityDistributions));
    String finalEstimationFormatted=String.valueOf(doubleFormat.format(Double.parseDouble(finalEstimation)));
%>
    <span>
    <%=LanguageUtil.format(pageContext,
							"result-message",
							new String[]{"<b>"+sumOfProbabilityDistributionsFormatted+"</b>", "<b>"+finalEstimationFormatted+"</b>"})%>
    </span>   
	
	<liferay-portlet:resourceURL copyCurrentRenderParameters="false" varImpl="exportResultsURL" id="exportResults"/>
	
	<aui:form action="<%=exportResultsURL%>" method="post" name="exprFm" >	
		<aui:input name="namealias" type="hidden" />
		<aui:input name="minEstalias" type="hidden" />
		<aui:input name="nominalEstalias" type="hidden" />
		<aui:input name="maxEstalias" type="hidden" />
		<aui:input name="expectedDeviationalias" type="hidden" />
		<aui:input name="expectedDurationalias" type="hidden" />
		
		<aui:input name="project" value="<%=project%>" label="project" inlineLabel="left" type="hidden"	/>
<%
		for (int i = 0; i < taskFieldsIndexes.length; i++) {
			int taskFieldIndex = taskFieldsIndexes[i];
			Task task = tasks.size()>0?tasks.get(i):new Task();			
%>									
			<aui:input name="<%=\"expname\" + taskFieldIndex%>" value="<%=task.getName()%>" type="hidden"/>
			<aui:input name="<%=\"expminEst\" + taskFieldIndex%>" value="<%=task.getMinEst()%>"	type="hidden"/>		
			<aui:input name="<%=\"expnominalEst\" + taskFieldIndex%>" value="<%=task.getNomEst()%>"	type="hidden"/>		
			<aui:input name="<%=\"expmaxEst\" + taskFieldIndex%>" value="<%=task.getMaxEst()%>" type="hidden"/>				
			<aui:input name="<%=\"expexpectedDeviation\" + taskFieldIndex%>" value="<%=task.getStandardDeviation()%>" type="hidden"/>				
			<aui:input name="<%=\"expexpectedDuration\" + taskFieldIndex%>"	value="<%=task.getExpectedDuration()%>"	type="hidden"/>					
			<aui:input name="<%=\"sumOfProbabilityDistributions\"%>" value="<%=sumOfProbabilityDistributionsFormatted%>" type="hidden"/>			
			<aui:input name="<%=\"finalEstimation\"%>" value="<%=finalEstimationFormatted%>" type="hidden"/>																	
	<% 	} %>
		<br />
		<aui:button name="test" value="Export to XLS" type="button" onClick='<%= renderResponse.getNamespace() + "exportXLS();" %>' />
	</aui:form>
<% } %>
<%@ include file="/html/scripts.jsp" %>