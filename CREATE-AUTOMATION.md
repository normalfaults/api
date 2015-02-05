## How to create ManageIQ Automation Scripts

This guide will walk through the steps to create and add automation scripts to your ManageIQ instance. These automation scripts
will allow you to provision additional services such as RDS and Storage buckets.

####Download and Install ManageIQ
Follow the steps provided here: http://manageiq.org/download/

###Creating an Automation Script
The following steps will guide you through the process of creating an automation script to interact with Jellyfish-UX and Jellyfish-Core. The automation scripts provided are located in in jellyfish-core/app/view/automate

####Adding an Automate Method
1. Once logged into ManageIQ, select Explorer under the Automation menu.
2. From the left side Datastore menu, select the Methods class located under Datastore/[your domain]/Service/Provisioning/StateMachines.
3. Select 'Add a new instance' from the configuration menu.
4. Enter a name in the 'Name' textbox. 'Display Name' and 'Description' are optional fields.
5. Under the 'Value' field next to 'execute', enter the same name from the step above.
6. Click 'Add' on the bottom right hand corner. 
7. Back on the Methods class page, click on 'Methods'.
8. Select 'Add a new method' from the configuration menu.
9. Give the method the same name that you created in Step 4.
10. Choose 'inline' for the Location
11. Paste in a method that has been provided, or one of your own.
12. Click 'Add' from the bottom right hand corner.

####Adding to a Provisioning Template
1. Under the left side Datastore menu, select the ServiceProvision_Template class.
2. Under the Configuration menu, select "Add a new instance"
3. Name your new instance. 'Display Name' and 'Description' are optional.
4. The template is where you supply the method to be executed for a particular service. The provisioning script will go in the 'Value' box of the 'provision' field. Also provided with this template are options for pre and post script execution methods.

####Adding a Catalog Item
1. Select Catalog under the Services menu.
2. Select Catalogs from the left hand side menu.
3. From the configuration menu, select 'Add a New Catalog'
4. Add in a Name and Description.
5. Select Catalog Items from the left hand side menu.
6. From the Configuration menu, select 'Add a New Catalog Item'
7. Input a Name and optional Description.
8. Check the 'display in Dialog' box
9. Choose a the Catalog that you previously created, or another one
10. Select whether you'd like to use a Dialog
11. Select the Provisioning Entry Point to be the Provisioning Template you created under Datastore/[your domain]/Service/Provisioning/StateMachines
12. For Reconfigure and Retirement entry points, you may select the default. 

####Adding a Dialog
1. Select Customization under the Automation menu.
2. On the left hand side, select Service Dialogs.
3. From the Configuration menu, select 'Add a new Dialog'
4. Label your Dialog and select a Submit button. 
5. From the '+' on the top, select 'Add a new Tab to this Dialog'
6. Label your tab and add an optional description.
7. From the '+" on the top, select 'Add a new Box to this Tab'
8. Label your box and add an optional description
9. From the '+' on the top, select 'Add a new Element to this Box'
10. Label and name your boxes. The name of the box is the value that will be passed through to your automation script. Depending on the type of Element that you choose, you will have different options.
11. When complete, select 'Save' from the bottom right hand corner. 

