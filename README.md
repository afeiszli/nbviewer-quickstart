Jupyter Notebook Viewer for OpenShift
=====================================

This repository contains software to make it easier to run the Jupyter notebook viewer on OpenShift.

Building Required Images
------------------------

To build the image for Jupyter notebook viewer which can be deployed on OpenShift, run:

```
oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/nbviewer-quickstart/master/images.json
```

This will create an image called ``nbviewer``.

Loading the Templates
---------------------

To load the templates from this repository for deploying the image, or using it as an S2I builder to create your own custom image with embedded notebook files, run:

```
oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/nbviewer-quickstart/master/templates.json
```

This will create the following templates:

* ``nbviewer-builder``
* ``nbviewer-deployer``
* ``nbviewer-quickstart``

Deploying the Notebook Viewer
-----------------------------

Once the ``nbviewer`` image has finished building, you can deploy an instance by running:

```
oc new-app --template nbviewer-deployer
```

The name of the deployment created will be ``nbviewer````. If you want to change the name, instead run:

```
oc new-app --template nbviewer-deployer \
  --param APPLICATION_NAME=my-nbviewer
```

Deleting the Application
------------------------

To delete the Jupyter notebook viewer instance, run:

```
oc delete all --selector app=my-nbviewer
```

Serving up Embedded Notebooks
-----------------------------

If you mount a persistent volume against the Jupyter notebook viewer instance, or build a custom image using the S2I build mechanism, you can enable access by enabling the ``localfiles`` feature of the Jupyter notebook viewer. This can be done by setting the ``NBVIEWER_LOCALFILES`` environment variable.

```
oc set env dc/my-nbviewer NBVIEWER_LOCALFILES=/opt/app-root/src
```

In your browser, when on the home page for the Jupyter notebook viewer site, add ``/localfile`` at the end of the URL to get a list of the files in the specified directory of the image, or persistent volume.

If desired, you could use the S2I build process to create a custom image with templates for the Jupyter notebook viewer, and set the ``NBVIEWER_TEMPLATE_PATH`` environment variable. This will allow you to customise the appearance of the home page.

Using the OpenShift Web Console
-------------------------------

The Jupyter notebook viewer can be deployed from the web console by selecting _Select from Project_ from the _Add to Project_ drop down menu and choosing _Notebook Viewer_.
