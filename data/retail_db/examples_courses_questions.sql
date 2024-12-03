-- Let us take care of exercises related to filtering and aggregations using SQL.
-- * Get all the details of the courses which are in `inactive` or `draft` state.
Select * from courses
where course_status in ('inactive','draft');

-- * Get all the details of the courses which are related to `Python` or `Scala`. 
Select * from courses
where course_name Like '%Python%' or course_name Like '%Scala%';

-- * Get count of courses by `course_status`. The output should contain `course_status` and `course_count`.
Select count(*) as course_count, course_status
from courses
group by course_status;

-- * Get count of `published` courses by `course_author`. The output should contain `course_author` and `course_count`.
Select count(*) as course_count, course_author
from courses
where course_status = 'published'
group by course_author;

-- * Get all the details of `Python` or `Scala` related courses in `draft` status.
Select *
from courses
where course_name Like '%Python%' or course_name Like '%Scala%' 
Group by course_name, course_id, course_author, course_status, course_published_dt
Having course_status = 'draft';

-- * Get the author and count where the author have more than **one published** course. 
--The output should contain `course_author` and `course_count`.
Select count(*) as course_count, course_author, course_status
from courses
where course_status = 'published'
Group by course_author, course_status;

