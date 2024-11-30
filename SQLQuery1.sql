/*creation DB */
create database BreastCancer

/*visulization of data*/

select * from breastcancer

select * from Cases

/* Describe data statistically*/
select 
    avg(radius_mean) AS avg_radius,
    avg(texture_mean) AS avg_texture,
    avg(perimeter_mean) AS avg_perimeter,
    avg(area_mean) AS avg_area,
    stdev(radius_mean) AS std_radius,
    stdev(texture_mean) AS std_texture
from breastcancer


/*Show Cases information and details*/
select *
from cases c
JOIN breastcancer  bc  on bc.id = c.id
where c.diagnosis = 'M'

select *
from breastcancer as bc
JOIN cases as c on bc.id = c.id
where c.diagnosis = 'B'


/*Number of benign and malignant cases*/

select diagnosis, COUNT(*) AS NumberOfCases
from cases
group by diagnosis


/*comparsion of the number of cases acording to Average*/
select c.diagnosis,
 avg(bc.radius_mean) AS avg_radius_mean,avg(bc.texture_mean) AS avg_texture_mean,
 avg(bc.perimeter_mean) AS avg_perimeter_mean,avg(bc.area_mean) AS avg_area_mean,  avg(smoothness_mean) As avg_smoothness_mean,
avg(compactness_mean) As avg_compactness_mean,avg(concavity_mean)AS avg_concavity_mean,
avg([concave points_mean]) AS avg_concave_points_mean,avg(symmetry_mean) AS avg_symmetry_mean,
avg(fractal_dimension_mean)AS avg_fractal_dimension_mean,avg(radius_se) AS avg_radius_se,
avg(texture_se) AS avg_texture_se,avg(perimeter_se) AS avg_perimeter_se,
avg(area_se) AS avg_area_se,avg(smoothness_se) AS avg_smoothness_se,
avg(concavity_se) AS avg_concavity_se,avg([concave points_se]) AS avg_concave_points_se,
avg(symmetry_se) AS avg_symmetry_se,avg(fractal_dimension_se) AS avg_fractal_dimension_se,
avg(radius_worst) AS avg_radius_worst,avg(texture_worst) AS avg_texture_worst,
avg(perimeter_worst) AS avg_perimeter_worst,avg(area_worst) AS avg_area_worst,
avg(smoothness_worst) AS avg_smoothness_worst,avg(compactness_worst) AS avg_compactness_worst,
avg(concavity_worst)AS avg_concavity_worst,avg([concave points_worst])AS avg_concave_points_worst,
avg(symmetry_worst)AS avg_symmetry_worst,avg(fractal_dimension_worst)AS avg_fractal_dimension_worst
  
from breastcancer bc
JOIN cases c on bc.id = c.id
group by c.diagnosis;


/*understand diagnosis with min & max*/
select c.diagnosis,
       max(area_se) as max_area_se,
       min(area_se) as min_area_se,
       max(smoothness_se) as max_smoothness_se,
       min(smoothness_se) as min_smoothness_se
from breastcancer bc
JOIN cases c on bc.id = c.id
group by c.diagnosis;

 /*How many cases their area mean bigger than 900*/
select diagnosis, COUNT(*) AS NumberOfCases
from cases c join breastcancer bc 
on bc.id = c.id
where (bc.area_mean)>900
group by c.diagnosis

/*How many cases their area worst bigger than 900*/
select diagnosis, COUNT(*) AS NumberOfCases
from cases c join breastcancer bc 
on bc.id = c.id
where (bc.area_worst)>1000
group by c.diagnosis

/**count cases their max smoothness_worst bigger than 0.1**/
select diagnosis, COUNT(*) AS NumberOfCases
from cases c join breastcancer bc 
on bc.id = c.id
group by c.diagnosis
having (max (smoothness_worst)>0.1)
ORDER BY NumberOfCases desc

/*the biggest perimeter_worst id*/
select id,perimeter_worst
from breastcancer
where perimeter_worst =(select max(perimeter_worst) from breastcancer)

/*The smallest concavity_se id and diagnosis*/
select c.id ,diagnosis, concavity_se
from breastcancer bc join cases c on bc.id = c.id
where  concavity_se =(select min(concavity_se) from breastcancer)