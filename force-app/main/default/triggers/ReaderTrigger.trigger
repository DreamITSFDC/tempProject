trigger ReaderTrigger on Reader__c (before insert, before update, after insert, after update) {
    List<Reader__c> rList = Trigger.New;
    List<Reader__c> oldRList = new List<Reader__c>();
    Map<Id, Reader__c> oldRMap = new Map<Id, Reader__c>();
    Date todayDate = System.today();
    
    if(Trigger.isUpdate) {
        oldRList = Trigger.Old;
        oldRMap = Trigger.OldMap;
    }
    
    if(Trigger.isBefore) {
        for(Reader__c r : rList) {
            if(r.DOB__c != null) {
                
                if(Trigger.isInsert
                   || (Trigger.isUpdate && oldRMap.containsKey(r.Id) && ( r.DOB__c != oldRMap.get(r.Id).DOB__c ) ) ) {
                       if(r.DOB__c >= todayDate ) {
                           r.addError('Please enter valid DOB. Future date cannot be stored.');
                       }
                       else {
                           Integer dobYear = r.DOB__c.year();
                           Integer currentYear = todayDate.year();
                           Integer diffYears = currentYear - dobYear;
                           //diffYears = 0;
                           if(diffYears <= 10) {
                               r.addError('Please enter valid DOB. Reader age should be greater than 10 years.');
                           }
                       }
                   }
            }
            
        }
    }
    
    if(Trigger.isAfter) {
        Task t = new Task();
        List<Task> taskList = new List<Task>();
        
        if(Trigger.isInsert) {
            for(Reader__c r : rList) {
                t = new Task();
                t.Status = 'Not Started';
                t.Priority = 'Normal';
                t.Subject = 'Contact the Reader for more information';
                t.WhatId = r.Id;
                t.ActivityDate = todayDate.addDays(10);
                taskList.add(t);
                //insert t;
            }
            
            insert taskList;
        }
    }
    
}

/*
//using Trigger.Old and using nested for loop

for(Reader__c oldR : oldRList) {
    if(r.Id == oldR.Id) {
        if( r.DOB__c != oldR.DOB__c) {
            Date todayDate = System.today();
            
            if(r.DOB__c >= todayDate ) {
                r.addError('Please enter valid DOB. Future date cannot be stored.');
            }
            else {
                Integer dobYear = r.DOB__c.year();
                Integer currentYear = todayDate.year();
                Integer diffYears = currentYear - dobYear;
                
                if(diffYears <= 10) {
                    r.addError('Please enter valid DOB. Reader age should be greater than 10 years.');
                }
            }
        }
    }
    
}

//using Trigger.OldMap and without code reusability
if(Trigger.isUpdate && oldRMap.size() > 0) {
        
        if(oldRMap.containsKey(r.Id)) {
            //Reader__c oldR = oldRMap.get(r.Id);
            //if( r.DOB__c != oldR.DOB__c) {
            if( r.DOB__c != oldRMap.get(r.Id).DOB__c) {
                Date todayDate = System.today();
                
                if(r.DOB__c >= todayDate ) {
                    r.addError('Please enter valid DOB. Future date cannot be stored.');
                }
                else {
                    Integer dobYear = r.DOB__c.year();
                    Integer currentYear = todayDate.year();
                    Integer diffYears = currentYear - dobYear;
                    
                    if(diffYears <= 10) {
                        r.addError('Please enter valid DOB. Reader age should be greater than 10 years.');
                    }
                }
            }
        }
    }
    else {
        Date todayDate = System.today();
        
        if(r.DOB__c >= todayDate ) {
            r.addError('Please enter valid DOB. Future date cannot be stored.');
        }
        else {
            Integer dobYear = r.DOB__c.year();
            Integer currentYear = todayDate.year();
            Integer diffYears = currentYear - dobYear;
            
            if(diffYears <= 10) {
                r.addError('Please enter valid DOB. Reader age should be greater than 10 years.');
            }
        }
    }
}
*/