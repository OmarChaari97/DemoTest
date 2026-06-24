public with sharing class AccountTriggerHandler {
    public static void updateAccountName(List<Account> accounts) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : accounts) {
            if (account.iscative__c && !account.Name.contains(Date.today().format('YYYY-MM-DD'))) {
                account.Name = account.Name + ' - ' + Date.today().format('YYYY-MM-DD');
                accountsToUpdate.add(account);
            }
        }
        if (!accountsToUpdate.isEmpty()) {
            List<Database.SaveResult> saveResults = Database.update(accountsToUpdate, false);
            for (Database.SaveResult saveResult : saveResults) {
                if (!saveResult.isSuccess()) {
                    System.debug('Erreur lors de la mise à jour du compte : ' + saveResult.getErrors()[0].getMessage());
                }
            }
        }
    }

    public static void afterUpdate(List<Account> accounts) {
        updateAccountName(accounts);
    }
}