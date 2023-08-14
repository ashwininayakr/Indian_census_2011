use PROJECT
select * from dbo.Data1
select * from dbo.Data2
--number of rows into our dataset
select count(*) from Data1
select count(*) from Data2

--dataset for jharkhand and bihar

select * from Data1 where State in ('Jharkhand' ,'Bihar')

--population of india
select sum(Population) Population from Data2

--average growth
select AVG(Growth)*100 AVG_GROWTH from Data1 

--average growth statewise
select state, avg(Growth)*100 AVG_GROWTH from Data1 group by State order by AVG_GROWTH desc

--average sex ratio per  state
select state,round(avg(Sex_Ratio),0) AVG_SEX_RATIO from Data1 group by State order by AVG_SEX_RATIO desc

--average literacy rate
select state, avg(Literacy) AVG_LITERACY_RATE from Data1 group by State order by AVG_LITERACY_RATE desc 

--average literacy rate>90
select top 3 state, avg(Literacy) AVG_LITERACY_RATE from Data1 group by State having avg(Literacy)>90 order by AVG_LITERACY_RATE desc 

--top 3 states with highest avg growth rate
select top 3 state, avg(Growth)*100 AVG_GROWTH from Data1 group by State order by AVG_GROWTH desc

--bottom 3 states in sex ratio
select top 3 state,round(avg(Sex_Ratio),0) AVG_SEX_RATIO from Data1 group by State order by AVG_SEX_RATIO 

--top most and bottom most 3 states from the same table at one display with same condition(literacy)
Drop table if exists #topstates;
create table #topstates(
State nvarchar(255),
topstate float)

insert into #topstates
select state, avg(Literacy) AVG_LITERACY_RATE from Data1 group by State order by AVG_LITERACY_RATE desc;
select * from #topstates order by topstate desc

Drop table if exists #bottomstates;
create table #bottomstates(
State nvarchar(255),
bottomstate float)

insert into #bottomstates
select state, avg(Literacy) AVG_LITERACY_RATE from Data1 group by State order by AVG_LITERACY_RATE;
select * from #bottomstates order by bottomstate 

select * from
(select top 3 * from #topstates order by topstate desc)a
union
select * from
(select top 3 * from #bottomstates order by bottomstate)b

--state starting with letter A
select distinct(State) from Data1 where State like 'A%'
