trigger AccountTrigger on Account (before delete) {
    
    if (Trigger.isDelete){
        for (account a : trigger.old){
            if (a.name == 'Infosys') {
            a.adderror(a.name + ' Account cannot be deleted per trigger');
            }
        }
    }
}