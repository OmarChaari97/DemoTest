<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Account_ReadOnly_Profile</fullName>
    <label>Account Read Only Profile</label>
    <userLicense>Salesforce</userLicense>
    <tabSettings>
        <tab>Account</tab>
        <visibility>DefaultOn</visibility>
    </tabSettings>
    <classAccesses>
        <apexClass>None</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <pageAccesses>
        <apexPage>None</apexPage>
        <enabled>false</enabled>
    </pageAccesses>
    <objectPermissions>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <object>Account</object>
    </objectPermissions>
    <permissionSet>Account_ReadOnly_PS</permissionSet>
</Profile>