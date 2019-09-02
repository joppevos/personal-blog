---
title: "Pipeline to test Dirty-Data"
date: 2019-08-28T10:36:17+02:00
draft: false
---
![diagram.png](/images/post_01/background.jpg)


#### Introduction
You have assumptions about data you receive. With these assumptions, predictions are made or information is displayed. But what if these assumptions are not correct or have changed over time?
Testing on assumptions is the standard in software development for decades, called Test Driven Development. In a new field like data science it is not so common, but should be just as important.

High impactproblems that occur are mostly found way further down stream when the predictions are made and information is already displayed to the client. The damage is done and you have to trace back the pipeline where it went wrong. A simple test on the data could prevent this from happening.

#### Pipeline diagram
There are loads of open source frameworks out there to write tests for software integration, but not so much for data checks. In the end a test is a test. All it does is make an assertion if its True or False.
I decided to modify the framework pytest to my needs and deploy it on AWS.

The rough plan was to make it easy for people to write data tests and make a dashboard that gives information when the test passed or failed. If a problem occurs and the test fails, than the person responsible for the client should be notified immediately. Below is a diagram of the complete pipeline.

![diagram.png](/images/post_01/diagram.png)

Each client has an EC2 where a written tests is automatically pulled from git. The tests will make assertions on the RDS database living on the clients AWS account. 

#### AWS
The status of each test will be sent to an SNS topic. People and services can subscribe to this topic. If something fails, SNS will notify the subscribed services. Lambda is also subscribed to the topic and parses the JSON with all information about the tests from SNS. Lambda than writes it in a RDS where a simple flask dashboard reads it out.

#### Dashboard
The dashboard currently displayed on a tv in the office. See image below.
Every client has its own card where the running processes and tests show green or red. 

![overview_01.jpg](/images/post_01/overview_01.jpg)

When you click on a client it will display all the running test on the EC2 with some general information about each test.

![overview_02.jpg](/images/post_01/overview_02.jpg)

#### Conclusion
Overall it is an interesting project that is growing every day with newly written data tests. When working on solutions it gives you the confidence that you are working on data that is clean and expected. This will give you in return some well deserved sleep at night.









