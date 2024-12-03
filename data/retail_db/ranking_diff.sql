CREATE TABLE Student_scores(
student_id INT Primary key,
student_scores INT)

INSERT INTO Student_scores VALUES
(1,980),
(2,980),
(3,960),
(4,990),
(5,920),
(6,960),
(7,980),
(8,960),
(9,940),
(10,940);

SELECT *
FROM Student_scores

-----------using rank() and dense_rank()--------------

SELECT * , rank() over (order by Student_scores DESC) as rnk,
           dense_rank() over (order by Student_scores DESC) as drnk
FROM Student_scores;


       

