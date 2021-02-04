public class AddPrimaryContact implements Queueable{
    private Contact c;
    private String state;
    
    public AddPrimaryContact(String state) {
        //this.c = c;
        this.state = state;
    }
    
    public void execute(QueueableContext context) {
        List<Account> ListAccount = [SELECT ID, Name, (Select id, FirstName, LastName from contacts)
                                     FROM ACCOUNT
                                     WHERE BillingState = :state LIMIT 200];
        
        List<Contact> lstContact = new List<Contact>();
        Integer counter = 1;
        
        for (Account acc : ListAccount) {
            Contact cont = new Contact();
            cont.LastName = acc.Name + counter;
            cont.AccountId =  acc.id;
            lstContact.add( cont );
            counter++;
        }
        
        if( lstContact.size() > 0 ) {
            insert lstContact;
        }
    }
    
}