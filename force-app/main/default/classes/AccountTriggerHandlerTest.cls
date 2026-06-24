@isTest
public class AccountTriggerHandlerTest {
    @testSetup
    static void setup() {
        // Créer un compte de test
        Account testAccount = new Account(Name = 'Compte de test');
        insert testAccount;
    }

    @isTest
    static void testUpdateAccountName() {
        // Récupérer le compte de test
        Account testAccount = [SELECT Id, Name, iscative__c FROM Account WHERE Name = 'Compte de test'];
        
        // Mettre à jour le champ iscative__c
        testAccount.iscative__c = true;
        update testAccount;

        // Vérifier que le nom du compte a été mis à jour
        testAccount = [SELECT Id, Name, iscative__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(true, testAccount.Name.contains(Date.today().format('YYYY-MM-DD')));
    }

    @isTest
    static void testNoUpdateAccountName() {
        // Récupérer le compte de test
        Account testAccount = [SELECT Id, Name, iscative__c FROM Account WHERE Name = 'Compte de test'];
        
        // Mettre à jour le champ iscative__c
        testAccount.iscative__c = false;
        update testAccount;

        // Vérifier que le nom du compte n'a pas été mis à jour
        testAccount = [SELECT Id, Name, iscative__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(false, testAccount.Name.contains(Date.today().format('YYYY-MM-DD')));
    }
}