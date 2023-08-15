USE PROJECT
Select * from Data1
Select * from Data2

--joining both table with 

--count of males and females

select d.State,SUM(d.males) Males,SUM(d.females) Females from (select c.District,c.State,round(c.Population/(c.Sex_Ratio+1),0) males,round((c.Population*c.Sex_Ratio/(c.Sex_Ratio+1)),0) females from
(select a.District,a.State,a.Sex_Ratio/1000 Sex_Ratio,b.Population from Data1 a 
INNER JOIN Data2 b ON a.District=b.District)c)d 
group by d.State 

--total literacy rate

select d.State,sum(d.Literate_people) total_literate,sum(d.Illiterate_people) total_illiterate from(select c.District,c.State,round((c.Literacy_Ratio*c.Population),0) Literate_people,round(((1-c.Literacy_Ratio)*c.Population),0)Illiterate_people from
(select a.District,a.State,a.Literacy/100 Literacy_Ratio,b.Population from Data1 a
INNER JOIN Data2 b
On a.District=b.District)c)d
group by d.state

--population in previous census

select sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
(select d.state,sum(d.previous_census_population) previous_census_population,sum(d.current_census_population) current_census_population from(select c.District,c.state,round(c.population/(1+c.growth),0) previous_census_population, c.population current_census_population from(select a.District,a.State,a.Growth,b.Population from Data1 a
INNER JOIN Data2 b
On a.District=b.District)c)d
group by d.state)e

--population vs area

select (t.total_area/t.previous_census_population) previous_census_population_vs_area,(t.total_area/t.current_census_population) current_census_population_vs_area from
(select h.*,i.total_area from(select '1' as keyy,f.* from (select sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
(select d.state,sum(d.previous_census_population) previous_census_population,sum(d.current_census_population) current_census_population from(select c.District,c.state,round(c.population/(1+c.growth),0) previous_census_population, c.population current_census_population from(select a.District,a.State,a.Growth,b.Population from Data1 a
INNER JOIN Data2 b
On a.District=b.District)c)d
group by d.state)e)f)h
INNER JOIN 
(select '1' as keyy,g.* from (select sum(area_km2) total_area from Data2)g)i ON h.keyy=i.keyy)t

--window
--output top 3 district from each state with highest literacy rate

select a.* from
(select district,state,literacy,rank() over (partition by state order by literacy desc) rnk from Data1)a
where a.rnk in (1,2,3) order by state