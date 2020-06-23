({
    handleSuccess : function(component, event, helper) {
        component.find("field").forEach(function(f){
            f.reset();
        });
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message" : "Employee has been added",
            "type": "success"
        });
        toastEvent.fire();
    },
})