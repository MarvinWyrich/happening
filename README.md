# happening
Efficient tracking and summarizing of daily events and activities in agile development teams.

This prototype is part of my bachelor thesis.
It was used for evaluating the usefulness of individual activity tracking with the possibility to automatically generate a summarized representation of daily activities and events of the whole team for a selected time period.

## motivation
You are part of an agile developement team.
Every day, a lot of events happen and some of them are important for other team members to know.
Especially whenever decisions were taken, new tasks emerged or unexpected incidents happened, and team members are not adequately informed it can become problematic.
In other words, communication is important.

Most of the everday events and activities in agile development teams are communicated in short standup meetings.
Unfortunately, these meetings are rarely documented or not documented at all.
Furthermore not every team member can attend each meeting.
Now imagine that you were absent for a while and you come back to your team.
It is pretty difficult to efficiently get a complete overview of what happened in the meantime and what is still relevant to you.  
And this is where *happening* will help you.

## vision and outlook

The vision is to have one single information source that sums up all the activities and events of my team for a selected time period.
Team members track their happenings in short form, just like they would do on Twitter.
Then *happening* will allow others to generate a summary of the whole team's activities, e.g. for the last seven days.

Some ideas for further work on the implementation:
* Integrate *happening* as a plugin in JIRA. Use available information about activites, such as newly created and recently closed issues, and enrich the summary with these information automatically
* Cluster entries of different team members for the same happening


## screenshots

![Screenshot add event](http://fs5.directupload.net/images/170216/3ftzrmri.png)

![Screenshot of the summary](http://fs5.directupload.net/images/170216/ly8295aa.png)
