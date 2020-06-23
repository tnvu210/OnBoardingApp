public class TrackProjectStatus_Extension {
    public Map<Id, ProjectListWrapper> projectToContact {get; set;}
	public TrackProjectStatus_Extension() {
        list<Project_Team__c> result = [SELECT Project__c, Team__c,
                                                       Status__c, Assignment_Start__c, Assignment_End__c 
                                                       FROM Project_Team__c];
        
        projectToContact = new Map<Id, ProjectListWrapper>();
        for(Project_Team__c pm : result){
            if(!projectToContact.containsKey(pm.Project__c)){
                projectToContact.put(pm.Project__c, new ProjectListWrapper(new List<Project_Team__c>()) );
            }
            projectToContact.get(pm.Project__c).pmList.add(pm);
        }
    }
    
    /*public Map<Id, ProjectListWrapper> getContactsByProject(){
        list<Project_Member__c> result = memberList; /*[SELECT Project__c, Contact__c,
                                                       Status__c, Assignment_Start__c, Assignment_End__c 
                                                       FROM Project_Member__c];
        
        Map<Id, ProjectListWrapper> projectToContact = new Map<Id, ProjectListWrapper>();
        for(Project_Member__c pm : result){
            if(!projectToContact.containsKey(pm.Project__c)){
                projectToContact.put(pm.Project__c, new ProjectListWrapper(new List<Project_Member__c>()) );
            }
            projectToContact.get(pm.Project__c).pmList.add(pm);
        }
        
        return projectToContact;
    }*/
    
    public PageReference save(){
        try{
            list<Project_Team__c> pms = new List<Project_Team__c>();
            for(Id i : projectToContact.keyset()){
                list <Project_Team__c> pml = projectToContact.get(i).pmList;
                for(Project_Team__c pm : pml){
                    pms.add(pm);
                }
            }
            update pms;
                
        }
        catch(DMLException e){
            
        }
        PageReference pg = new PageReference('/apex/TrackProjectStatus');
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/apex/OnboardingAppWebPage');
        pg.setRedirect(true);
        return pg;
    }
    
    class ProjectListWrapper {
       
       public list<Project_Team__c> pmList {get; set;}
       
       public Integer numOfContacts {
          get{
            return pmList.size();
          }
          set;
       }
       
       public Id firstOfList{
          get{
            return pmList[0].Id;
          }
          set;
       }
             
       public ProjectListWrapper(List<Project_Team__c> listPm){
           pmList = listPm;
           
       }
    }
       
}