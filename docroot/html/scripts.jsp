<aui:script use="liferay-auto-fields">	
    new Liferay.AutoFields(
        {            
            contentBox: 'fieldset.tasks',
            baseRows:  '#<portlet:namespace />tasks',
            fieldIndexes: '<portlet:namespace />taskIndexes',
            sortable: false
        }
    ).render();
</aui:script>
<aui:script>
	function <portlet:namespace />calculate(){
		var A = AUI();		
		var form = A.one(document.<portlet:namespace />fm);		
		submitForm(form);		
	}
	
	function <portlet:namespace />exportXLS(){
		<!-- Grab all elements named expname* that are visible-->
		var $sans = $(":input[name^='<portlet:namespace />expname']");
		var DOMsans = $sans.get();
		document.<portlet:namespace />exprFm.<portlet:namespace />namealias.value='';
		for (var i = 0; i < DOMsans.length; i++) {			
			document.<portlet:namespace />exprFm.<portlet:namespace />namealias.value=document.<portlet:namespace />exprFm.<portlet:namespace />namealias.value.concat(DOMsans[i].value);
			document.<portlet:namespace />exprFm.<portlet:namespace />namealias.value=document.<portlet:namespace />exprFm.<portlet:namespace />namealias.value.concat('$');				
		}
		
		<!-- Grab all elements named expminEst* that are visible-->
		var $sans = $(":input[name^='<portlet:namespace />expminEst']");
		var DOMsans = $sans.get();
		document.<portlet:namespace />exprFm.<portlet:namespace />minEstalias.value='';
		for (var i = 0; i < DOMsans.length; i++) {				
			document.<portlet:namespace />exprFm.<portlet:namespace />minEstalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />minEstalias.value.concat(DOMsans[i].value);
			document.<portlet:namespace />exprFm.<portlet:namespace />minEstalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />minEstalias.value.concat('$');				
		}
		
		<!-- Grab all elements named expnominalEst* that are visible-->
		var $sans = $(":input[name^='<portlet:namespace />expnominalEst']");
		var DOMsans = $sans.get();
		document.<portlet:namespace />exprFm.<portlet:namespace />nominalEstalias.value='';
		for (var i = 0; i < DOMsans.length; i++) {				
			document.<portlet:namespace />exprFm.<portlet:namespace />nominalEstalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />nominalEstalias.value.concat(DOMsans[i].value);
			document.<portlet:namespace />exprFm.<portlet:namespace />nominalEstalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />nominalEstalias.value.concat('$');				
		}
		
		<!-- Grab all elements named expmaxEst* that are visible-->
		var $sans = $(":input[name^='<portlet:namespace />expmaxEst']");
		var DOMsans = $sans.get();
		document.<portlet:namespace />exprFm.<portlet:namespace />maxEstalias.value='';
		for (var i = 0; i < DOMsans.length; i++) {			
			document.<portlet:namespace />exprFm.<portlet:namespace />maxEstalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />maxEstalias.value.concat(DOMsans[i].value);
			document.<portlet:namespace />exprFm.<portlet:namespace />maxEstalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />maxEstalias.value.concat('$');				
		}
		
		<!-- Grab all elements named expexpectedDeviation* that are visible-->
		var $sans = $(":input[name^='<portlet:namespace />expexpectedDeviation']");
		var DOMsans = $sans.get();
		document.<portlet:namespace />exprFm.<portlet:namespace />expectedDeviationalias.value='';
		for (var i = 0; i < DOMsans.length; i++) {			
			document.<portlet:namespace />exprFm.<portlet:namespace />expectedDeviationalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />expectedDeviationalias.value.concat(DOMsans[i].value);
			document.<portlet:namespace />exprFm.<portlet:namespace />expectedDeviationalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />expectedDeviationalias.value.concat('$');				
		}
		
		<!-- Grab all elements named expexpectedDuration* that are visible-->
		var $sans = $(":input[name^='<portlet:namespace />expexpectedDuration']");
		var DOMsans = $sans.get();
		document.<portlet:namespace />exprFm.<portlet:namespace />expectedDurationalias.value='';
		for (var i = 0; i < DOMsans.length; i++) {			
			document.<portlet:namespace />exprFm.<portlet:namespace />expectedDurationalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />expectedDurationalias.value.concat(DOMsans[i].value);
			document.<portlet:namespace />exprFm.<portlet:namespace />expectedDurationalias.value=document.<portlet:namespace />exprFm.<portlet:namespace />expectedDurationalias.value.concat('$');				
		}	
		document.getElementById("<portlet:namespace />exprFm").submit();			
	}
</aui:script>