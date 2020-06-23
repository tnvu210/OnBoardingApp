public class TrackTrainingStatus_Extension {
    public String selectedValue {get;set;}
    public List<SelectOption> getValueOptions() {
        List<SelectOption> valueOptions = new List<SelectOption>();
        valueOptions = new List<SelectOption>();
        valueOptions.add(new SelectOption('All','All'));
        valueOptions.add(new SelectOption('Not Started','Not Started'));
        valueOptions.add(new SelectOption('In Progress','In Progress'));   
        valueOptions.add(new SelectOption('Completed','Completed'));
        return valueOptions;
    }
    
    public Map<Id, EmployeeListWrapper> courseToContact {get; set;}
    List<Training_Catalog_Assignment__c> result {get;set;}
    
    public TrackTrainingStatus_Extension() {
        getResults();
        /*if(selectedValue == null){
            this.result = new List<Training_Catalog_Assignment__c>();
            this.result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c];
        }
        
        courseToContact = new Map<Id, EmployeeListWrapper>();
        for(Training_Catalog_Assignment__c tca : result){
            if(!courseToContact.containsKey(tca.Employee__c)){
                courseToContact.put(tca.Employee__c, new EmployeeListWrapper(new List<Training_Catalog_Assignment__c>()) );
            }
            courseToContact.get(tca.Employee__c).tcaList.add(tca);
        }*/
    }
    
    public PageReference getResults(){
        if(selectedValue == 'All'){
            this.result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c];
        }else if(selectedValue == 'Completed'){
            this.result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c WHERE Status__c =: 'Completed'];
        }else if(selectedValue == 'Not Started'){
            this.result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c WHERE Status__c =: 'Not Started'];
        }else if(selectedValue == 'In Progress'){
            this.result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c WHERE Status__c =: 'In Progress'];
        }
        else{
            this.result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c];
        }
        courseToContact = new Map<Id, EmployeeListWrapper>();
        for(Training_Catalog_Assignment__c tca : result){
            if(!courseToContact.containsKey(tca.Employee__c)){
                courseToContact.put(tca.Employee__c, new EmployeeListWrapper(new List<Training_Catalog_Assignment__c>()) );
            }
            courseToContact.get(tca.Employee__c).tcaList.add(tca);
        }
        return null;
    }
    
    /*
    public Map<Id, EmployeeListWrapper> getCoursesByContact(){
        list<Training_Catalog_Assignment__c> result = [SELECT Employee__c, Training_Catalog__c, 
                                                       Status__c, Start_Date__c, End_Date__c 
                                                       FROM Training_Catalog_Assignment__c];
        
        Map<Id, EmployeeListWrapper> contactToCourse = new Map<Id, EmployeeListWrapper>();
        for(Training_Catalog_Assignment__c tca : result){
            if(!contactToCourse.containsKey(tca.Employee__c)){
                contactToCourse.put(tca.Employee__c, new EmployeeListWrapper(new List<Training_Catalog_Assignment__c>()) );
            }
            contactToCourse.get(tca.Employee__c).tacList.add(tca);
        }
        
        return contactToCourse;
    }
    */

    public PageReference save(){
        try{
            list<Training_Catalog_Assignment__c> tcas = new List<Training_Catalog_Assignment__c>();
            for(Id i : courseToContact.keyset()){
                list <Training_Catalog_Assignment__c> tcal = courseToContact.get(i).tcaList;
                for(Training_Catalog_Assignment__c tca : tcal){
                    tcas.add(tca);
                }
            }
            update tcas;
                
        }
        catch(DMLException e){
            
        }
        PageReference pg = new PageReference('/apex/TrackTrainingStatus');
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/apex/OnboardingAppWebPage');
        pg.setRedirect(true);
        return pg;
    }    
    
    
    class EmployeeListWrapper {
       
       public List<Training_Catalog_Assignment__c> tcaList {get; set;}
       
       public Integer numOfCourses {
          get{
            return tcaList.size();
          }
          set;
       }
       
       public Id firstOfList{
          get{
            return tcaList[0].Id;
          }
          set;
       }
             
       public EmployeeListWrapper(List<Training_Catalog_Assignment__c> listTca){
           tcaList = listTca;
           
       }
    }
}