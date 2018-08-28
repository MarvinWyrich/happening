# happening
Efficient tracking and summarizing of daily events and activities in agile development teams.

This prototype is part of my bachelor thesis.
It was used for evaluating the usefulness of individual activity tracking with the possibility to automatically generate a summarized representation of daily activities and events of the whole team for a selected time period.

## publication
Wyrich, M., Bogicevic, I., Wagner, S.: Improving Communication in Scrum Teams. In Proceedings of the International Conference on Product-Focused Software Process Improvement (PROFES 2017). Springer, 2017. [doi:10.1007/978-3-319-69926-4_50](https://link.springer.com/chapter/10.1007%2F978-3-319-69926-4_50)

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

## installation

- Clone or download the repository.
- Install [composer](https://getcomposer.org/download/).
- Install the dependencies of *happening* with composer.
- Put everything on your server. We tested happening with PHP 5.6 and the specified dependency versions in [composer.json](https://github.com/MarvinWyrich/happening/blob/master/composer.json).
- Use [sql_dump.sql](https://github.com/MarvinWyrich/happening/blob/master/sql_dump.sql) for creating the tables of the database. There is not yet an admin interface and therefore users have to be managed via the database interface.

## demo

You can find a demo installation on http://marvin-wyrich.de/happening. The tool consists of two parts: a simple form for inserting individual events and a page for viewing the summary for a selected time period.
