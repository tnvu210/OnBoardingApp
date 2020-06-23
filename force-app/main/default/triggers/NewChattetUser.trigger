trigger NewChattetUser on Contact (before insert) {
    /*
    List<User> users = new List<User>();
    Profile pro = [SELECT Id, Name FROM Profile WHERE Name =: 'Chatter Free User'];
            
    for (Contact c: trigger.new){
        User u = new User();
        u.FirstName = c.FirstName;
        u.LastName = c.LastName;
        u.Email = c.Email;
        u.Username = u.FirstName + '.' + u.LastName + '@.sf.infosys.com';
        u.ProfileId = pro.Id;
        u.Alias = c.LastName;
        u.IsActive = true; 
        u.TimeZoneSidKey = 'GMT';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LocaleSidKey = 'en_US';
        u.ContactId = c.Id;
        
        users.add(u);       
    }
    insert users;
    */
    
}