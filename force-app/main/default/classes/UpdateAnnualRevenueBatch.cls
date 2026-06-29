public with sharing class UpdateAnnualRevenueBatch implements Schedulable, Database.Batchable<sObject> {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new UpdateAnnualRevenueBatch());
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, AnnualRevenue FROM Account WHERE AnnualRevenue = 0';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : (List<Account>) scope) {
            account.AnnualRevenue = 150000;
            accountsToUpdate.add(account);
        }
        List<Database.SaveResult> saveResults = Database.update(accountsToUpdate, false);
        for (Database.SaveResult saveResult : saveResults) {
            if (!saveResult.isSuccess()) {
                System.debug('Error updating account: ' + saveResult.getId() + ', ' + saveResult.getErrors());
            } else {
                // Créer un journal d'activité pour chaque compte mis à jour
                Task task = new Task(
                    WhatId = saveResult.getId(),
                    Subject = 'Mise à jour du revenu annuel',
                    Description = 'Le revenu annuel a été mis à jour de 0 à 150 000.'
                );
                insert task;
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch terminé');
    }
}