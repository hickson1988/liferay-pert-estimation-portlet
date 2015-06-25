package com.portlet.estimationcalculator;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.util.JavaConstants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.util.bridges.mvc.MVCPortlet;
import com.portlet.estimationcalculator.beans.Task;
import com.portlet.estimationcalculator.util.ExportUtil;

/**
 * 
 * @author Michael Hickson
 *
 */
public class EstimationCalculator  extends MVCPortlet {
    
    @Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException  {
		if(_log.isDebugEnabled()){
			_log.debug("serveResource");
		}
		exportResults(resourceRequest,resourceResponse);
	}
   
	public void exportResults(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException {
		if(_log.isDebugEnabled()){
			_log.debug("exportResults");
		}
		
		Locale locale = resourceRequest.getLocale();
		
		PortletConfig portletConfig = (PortletConfig) resourceRequest.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
		
		String namealias = ParamUtil.getString(resourceRequest,"namealias");
		String minEstalias = ParamUtil.getString(resourceRequest,"minEstalias");
		String nominalEstalias = ParamUtil.getString(resourceRequest,"nominalEstalias");
		String maxEstalias = ParamUtil.getString(resourceRequest,"maxEstalias");
		String expectedDeviationalias = ParamUtil.getString(resourceRequest,"expectedDeviationalias");
		String expectedDurationalias = ParamUtil.getString(resourceRequest,"expectedDurationalias");
		String sumOfProbabilityDistributions = ParamUtil.getString(resourceRequest,"sumOfProbabilityDistributions");
		String finalEstimation = ParamUtil.getString(resourceRequest,"finalEstimation");
		String project = ParamUtil.getString(resourceRequest,"project");
		
		if (_log.isDebugEnabled()) {
			_log.debug("namealias: " + namealias);
			_log.debug("minEstalias: " + minEstalias);
			_log.debug("nominalEstalias: " + nominalEstalias);
			_log.debug("maxEstalias: " + maxEstalias);
			_log.debug("expectedDeviationalias: " + expectedDeviationalias);
			_log.debug("expectedDurationalias: " + expectedDurationalias);
			_log.debug("sumOfProbabilityDistributions: " + sumOfProbabilityDistributions);
			_log.debug("finalEstimation: " + finalEstimation);
			_log.debug("project: " + project);
		}
				
		ExportUtil.exportXLS(resourceRequest, resourceResponse, locale, portletConfig,
				namealias, minEstalias, nominalEstalias, maxEstalias,
				expectedDeviationalias, expectedDurationalias,
				sumOfProbabilityDistributions, finalEstimation, project);	
	}
    
    public void calculateEstimation(ActionRequest actionRequest,
		ActionResponse actionResponse) throws IOException {
		if (_log.isDebugEnabled())
			_log.debug("calculateEstimation(ActionRequest actionRequest, ActionResponse actionResponse)");
		
		List<Task> tasks =populateTaskBeans(actionRequest);
		validate(actionRequest,tasks);
		calculateEstimations(actionRequest,tasks);
	
		actionRequest.setAttribute("project",ParamUtil.getString(actionRequest,"project"));
		actionRequest.setAttribute("tasks",tasks);			
    }

    private void calculateEstimations(ActionRequest actionRequest,
	    List<Task> tasks) {
		if(SessionErrors.isEmpty(actionRequest)){
			
		    DecimalFormat doubleFormat=new DecimalFormat("#.##"); 
		    double sumOfProbabilityDistributions=0;
		    double sumOfStandardDeviations=0;
		    double finalEstimation=0;
		    
        	for(Task task:tasks){
        	    double optimisticEstimate = Double.parseDouble(task.getMinEst());		
        		double nominalEstimate = Double.parseDouble(task.getNomEst());		
        		double pessimisticEstimate = Double.parseDouble(task.getMaxEst());
            		
        		double probabilityDistribution=(optimisticEstimate+(4*nominalEstimate)+pessimisticEstimate)/6;
        		double standardDeviation=(pessimisticEstimate-optimisticEstimate)/6;	
	
        		task.setExpectedDuration(String.valueOf(doubleFormat.format(probabilityDistribution)));
        		task.setStandardDeviation(String.valueOf(doubleFormat.format(standardDeviation)));
        		
        		if (_log.isDebugEnabled()){
        		    _log.debug("#Task: "+task.getName());
        			_log.debug("probabilityDistribution (m): "+probabilityDistribution);
        			_log.debug("standardDeviation: "+standardDeviation);        		
        		}
        		
        	    sumOfProbabilityDistributions=sumOfProbabilityDistributions+probabilityDistribution;
    			sumOfStandardDeviations=sumOfStandardDeviations+(standardDeviation*standardDeviation);
        	}
        	sumOfStandardDeviations=Math.sqrt(sumOfStandardDeviations);
        	finalEstimation=sumOfProbabilityDistributions+sumOfStandardDeviations;	
        	
        	if (_log.isDebugEnabled()){
    			_log.debug("sumOfProbabilityDistributions: "+sumOfProbabilityDistributions);
    			_log.debug("sumOfStandardDeviations: "+sumOfStandardDeviations);
    			_log.debug("finalEstimation: "+finalEstimation);
        	}
        	
        	actionRequest.setAttribute("sumOfProbabilityDistributions",String.valueOf(sumOfProbabilityDistributions));
        	actionRequest.setAttribute("finalEstimation",String.valueOf(finalEstimation));	        	
		}
    }

    private List<Task> populateTaskBeans(ActionRequest actionRequest) {	
		List<Task> tasks = new ArrayList<Task>();		
		String taskIndexes = ParamUtil.getString(actionRequest,"taskIndexes");
	
		if (_log.isDebugEnabled()) {
			_log.debug("taskIndexes: " + taskIndexes);
		}
		
		int[] taskIntIndexes = StringUtil.split(taskIndexes, 0);
		
		for (int i = 0; i < taskIntIndexes.length; i++) {
		    
	    	String name =ParamUtil.getString(actionRequest,"name" + taskIntIndexes[i]);	    
	    	String optimisticEstimateString =ParamUtil.getString(actionRequest,"minEst" + taskIntIndexes[i]);		
	    	String nominalEstimateString = ParamUtil.getString(actionRequest,"nominalEst" + taskIntIndexes[i]);		
	    	String pessimisticEstimateString =ParamUtil.getString(actionRequest,"maxEst" + taskIntIndexes[i]);	    	
	    
	    	if (_log.isDebugEnabled()) {
	    	    _log.debug("name: " + name);
				_log.debug("optimisticEstimate: " + optimisticEstimateString);
				_log.debug("nominalEstimate: " + nominalEstimateString);
				_log.debug("pessimisticEstimate: " + pessimisticEstimateString);
			}
			
			Task task = new Task(name,optimisticEstimateString,nominalEstimateString,pessimisticEstimateString);			
			tasks.add(task);		
		}
		return tasks;
    }

    private void validate(ActionRequest actionRequest, List<Task> tasks) {
		for(Task task:tasks){
		    if(Validator.isNull(task.getMinEst()) || 
		    		Validator.isNull(task.getMaxEst()) ||
		    		Validator.isNull(task.getNomEst())){
		    	SessionErrors.add(actionRequest, "emptyField");	    	  
		    }		    		    
		    
		    if(!isIntOrDouble(task.getMinEst()) || 
		    		!isIntOrDouble(task.getMaxEst()) ||
		    		!isIntOrDouble(task.getNomEst())){
		    	SessionErrors.add(actionRequest, "numericExpected");	    	  
		    }
		}
    }
    
    private boolean isIntOrDouble(String value) {    	
	    try {
	        Integer.parseInt(value);       
	    } catch (NumberFormatException e) {
	        if (!value.matches("-?\\d+(\\.\\d+)?")) {	        	
	        	return false;	
	        }
	    }
	    return true;
    }
    
    private static Log _log = LogFactoryUtil.getLog(EstimationCalculator.class);
}
