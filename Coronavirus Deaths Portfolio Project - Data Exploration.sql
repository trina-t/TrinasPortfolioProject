
/*

Coronavirus Data Exploration

This dataset pertains to coronavirus-related global deaths. As part of this data 
exploration project, I employed various SQL functions to get a better understanding 
of cases and death rates by continent. As a public health professional, I was 
curious about the mortality rates, deaths per 100k population, infection rates, and 
reported vaccination rates by continent. By exploring these figures, we can uncover 
potential trends of the disease.

I notice the dataset contains several null values which are due to a lack of resources 
available at the time. Due to this, these numbers and percentage rates by continent may
not reflect the true reality of coronavirus-related deaths.  

*/



select *
from coviddeaths

select 
	location
	,date
	,new_cases
	,total_deaths
	,population
from coviddeaths
order by 1,2 


/*

This analysis investigates the correlation between the total number of cases and total 
deaths for each continent. Additionally, this yielded valuable insights by identifying
the continent with the highest percentage of deaths.

*/

select *
from coviddeaths

alter table coviddeaths
	add death_percentage varchar(255);

select 
	location
	,date
	,total_cases
	,total_deaths
	,population
	,death_percentage
from coviddeaths

update coviddeaths
	set death_percentage = ( (total_deaths/total_cases) * 100 )

select 
	continent
	, MAX (death_percentage ) as death_percentage_by_continent
from coviddeaths
	where continent is not null
	group by continent	
	order by death_percentage_by_continent desc



/*

This analysis focuses on exploring the mortality rate. The mortality rate is the number 
of deaths divided by total population.

*/

select 
	location
	,date
	,total_cases
	,total_deaths
	,population
	,death_percentage
from coviddeaths

alter table coviddeaths
	add mortality_rate varchar(255);

update coviddeaths
	set mortality_rate = ( (total_deaths/population) * 100 )

select 
	location
	,date
	,total_cases
	,total_deaths
	,population
	,death_percentage
	,mortality_rate
from coviddeaths
order by 1,2

select 
	continent
	, MAX (mortality_rate) as mortality_rate_continent
from coviddeaths
	where continent is not null
	group by continent	
	order by mortality_rate_continent desc



/*

The dataset currently provides total deaths per million, but I am interested in calculating 
the total deaths per 100,000 population. This rate offers a more meaningful way to compare 
deaths across population groups of varying sizes, enabling more accurate and insightful comparisons.

*/

alter table coviddeaths
	add deaths_per_100k_population int;

update coviddeaths
	set deaths_per_100k_population = ( (total_deaths/population) * 100000 )

select 
	location
	,date
	,total_cases
	,total_deaths
	,population
	,death_percentage
	,mortality_rate
	,deaths_per_100k_population
from coviddeaths
order by 1,2 desc

select 
	continent
	, MAX (deaths_per_100k_population) as deaths_per_100k_population_by_country
from coviddeaths
	where continent is not null
	group by continent	
	order by deaths_per_100k_population_by_country desc



/*

This analysis focuses on exploring the prevalence. Prevalence is a measure of how 
widespread a disease or condition is in a population at a given moment. 

*/

alter table coviddeaths
	add population_infected_percentage decimal(5,2);

update coviddeaths
	set population_infected_percentage = ( ( total_cases/population ) * 100 )

select 
	location
	,date
	,total_cases
	,total_deaths
	,population
	,death_percentage
	,mortality_rate
	,population_infected_percentage
from coviddeaths
order by population_infected_percentage desc

select 
	continent
	, MAX (population_infected_percentage) as population_infected_percentage_by_continent
from coviddeaths
	where continent is not null
	group by continent	
	order by population_infected_percentage_by_continent desc



/*

This showcases the continents with the highest death count.

*/

select 
	continent, MAX ( cast(total_deaths as int) ) as total_death_count
from coviddeaths
	group by continent
	order by total_death_count desc



/*

This showcases the continents with the highest reported vaccination rates.

*/


select continent, MAX ( cast(total_vaccinations as int)) as total_vaccination_count
from coviddeaths
	where continent is not null
	group by continent 
	order by total_vaccination_count desc
