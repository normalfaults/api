## How to create ManageIQ Automation Scripts

This guide will walk through the steps to create and add automation scripts to your ManageIQ instance. These automation scripts
will allow you to provision additional services such as RDS and Storage buckets.

####Download and Install ManageIQ
Follow the steps provided here: http://manageiq.org/download/

####Adding an Automate Method
1. Once logged into ManageIQ, select Explorer under the Automation menu.
2. From the left hand side Datastore menu, select the Methods class located under Datastore/[your domain]/Service/Provisioning/StateMachines.
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
1. Under the Datastore menu, select the ServiceProvision_Template class.
2. Under the Configuration menu, select "Add a new instance"
3. Name your new instance. 'Display Name' and 'Description' are optional.
4. The template is where you supply the method to be executed for a particular service. The provisioning script will go in the 'Value' box of the 'provision' field. Also provided with this template are options for pre and post script execution methods.

####Adding a Catalog Item
