public with sharing class ApexBasics_V10_Sud_04Feb20 {
    public Integer n1 {get; set;}
    public Integer n2 {get; set;}
    
    public ApexBasics_V10_Sud_04Feb20() {
        n1 = 100;
        n2 = 200;
        Integer res = n1 + n2;

        System.debug('Value of res : ' + res);
    }
    
    public void arithmaticOps () {
        n1 = 100;
        n2 = 200;
        Integer res = n1 + n2;

        System.debug('Value of res : ' + res);
    }
}