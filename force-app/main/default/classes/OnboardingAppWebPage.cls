public class OnboardingAppWebPage {
	public String selectedValue {get;set;}
    
    
    public List<SelectOption> getValueOptions() {
        List<SelectOption> valueOptions = new List<SelectOption>();
        valueOptions = new List<SelectOption>();
        valueOptions.add(new SelectOption('','-None-'));
        valueOptions.add(new SelectOption('Training','Assigned Training Course and Status'));
        valueOptions.add(new SelectOption('Project','Assigned Project and Status'));
        
        return valueOptions;
     
    }
  
    public void clearValue(){
        selectedValue ='None';    
    }
    
    public PageReference switchPage() {
        if(selectedValue == 'Training'){
            PageReference pg = new PageReference('/apex/TrackTrainingStatus');
            pg.setRedirect(true);
            return pg;
        }
        else if(selectedValue == 'Project'){
            PageReference pg = new PageReference('/apex/TrackProjectStatus');
            pg.setRedirect(true);
            return pg;
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Pick a value'));
            return null;
        }
	
	}
    
    public PageReference redirectToHomePage() {
        PageReference pageRef = new PageReference('/home/home.jsp');
        pageRef.setRedirect(true);
    	return pageRef;  
}
 
}