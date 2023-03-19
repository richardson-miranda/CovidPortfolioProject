SELECT * 
From CovidPortfolioProject..CovidDeaths$
order by 3,4

--SELECT * 
--From CovidPortfolioProject..CovidVaccinations$
--order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidPortfolioProject..CovidDeaths$
Order by 1,2


-- Total Cases vs Total Deaths
Select Location, date, total_cases, total_deaths, (Total_deaths/total_cases)*100 as DeathPercentage
From CovidPortfolioProject..CovidDeaths$
where location like '%states%'
Order by 1,2


--  Total Cases vs Population
Select Location, date, population, total_cases, (total_cases/population)*100 as PopulationContraction
From CovidPortfolioProject..CovidDeaths$
where location like '%states%'
Order by 1,2


--  Highest Infection Rate to Population 
Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PopulationContraction
From CovidPortfolioProject..CovidDeaths$
--where location like '%states%'
Group By Location, population
Order by PopulationContraction DESC


-- Highest Death Count Per Population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidPortfolioProject..CovidDeaths$
--where location like '%states%'
Where continent is not null
Group By Location
Order by TotalDeathCount DESC


-- CONTINENT BREAKDOWN
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidPortfolioProject..CovidDeaths$
Where continent is not null
Group By continent
Order by TotalDeathCount DESC


-- GLOBAL BREAKDOWN
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From CovidPortfolioProject..CovidDeaths$
where continent is not null
order by 1,2


-- Total Population vs Vaccinations
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
From  CovidPortfolioProject..CovidDeaths$ as d
Join CovidPortfolioProject..CovidVaccinations$ as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null
order by 2,3


-- CTE
With PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
From  CovidPortfolioProject..CovidDeaths$ as d
Join CovidPortfolioProject..CovidVaccinations$ as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopVsVac


-- TEMP TABLE
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert Into #PercentPopulationVaccinated
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
From  CovidPortfolioProject..CovidDeaths$ as d
Join CovidPortfolioProject..CovidVaccinations$ as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- View To Store Data For Visualization 
USE CovidPortfolioProject 
GO 
Create View PercentPopulationVaccinated as
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
From  CovidPortfolioProject..CovidDeaths$ as d
Join CovidPortfolioProject..CovidVaccinations$ as v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null


Select * 
From PercentPopulationVaccinated


