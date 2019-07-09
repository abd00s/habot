## Data Model UML

![](https://yuml.me/b0787147.png)

[//]: # (http://yuml.me/diagram/plain/class/edit/[User|first_name; last_name]-0..*>[Goal|user_id; title; frequency; period:enum],[Goal]-0..*>[GoalPeriod|goal_id; start_date; goal_met:bool], [GoalPeriod]-0..*>[Event| goal_period_id; date])
