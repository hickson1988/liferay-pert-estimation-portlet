package com.portlet.estimationcalculator.beans;

public class Task {
    private String name;
    
    private String minEst;
    private String nomEst;
    private String maxEst;
    
    private String expectedDuration;
    private String standardDeviation;
    

    public Task() {
   
       }
    
    public Task(String name, String minEst, String nomEst, String maxEst) {
	super();
	this.name = name;
	this.minEst = minEst;
	this.nomEst = nomEst;
	this.maxEst = maxEst;
	
    }
   
    public Task(String name, String minEst, String nomEst, String maxEst,
	    String expectedDuration, String standardDeviation) {
	super();
	this.name = name;
	this.minEst = minEst;
	this.nomEst = nomEst;
	this.maxEst = maxEst;
	this.expectedDuration = expectedDuration;
	this.standardDeviation = standardDeviation;
    }

    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }

    public String getMinEst() {
        return minEst;
    }


    public void setMinEst(String minEst) {
        this.minEst = minEst;
    }


    public String getNomEst() {
        return nomEst;
    }


    public void setNomEst(String nomEst) {
        this.nomEst = nomEst;
    }


    public String getMaxEst() {
        return maxEst;
    }


    public void setMaxEst(String maxEst) {
        this.maxEst = maxEst;
    }


    public String getExpectedDuration() {
        return expectedDuration;
    }


    public void setExpectedDuration(String expectedDuration) {
        this.expectedDuration = expectedDuration;
    }


    public String getStandardDeviation() {
        return standardDeviation;
    }


    public void setStandardDeviation(String standardDeviation) {
        this.standardDeviation = standardDeviation;
    }


   
}
