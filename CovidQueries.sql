
USE CovidProject;


--Total cases vs total deaths
--Shows likelihood of dying if you contract covid in greece

SELECT LOCATION,DATE, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths$
WHERE LOCATION like '%greece%'
order by 1,2;

-- Looking at Total Cases vs Population in greece
--Shows what percentage of population got covid

SELECT location,date,total_cases,population, (total_deaths/population)*100 as DeathPercentage
FROM CovidDeaths$
WHERE LOCATION like '%greece%'
order by location,date;

--Looking at Countries with Highest Infection Rate compared to Population

SELECT Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths$
Group by location,population
Order by PercentPopulationInfected desc

--Showing Countries with Highest Death Count per Population
SELECT Location, max(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths$
WHERE continent is not null
Group by Location
order by TotalDeathCount desc

--Showing Continent and Death count
--1
SELECT Continent, max(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths$
WHERE continent is not null
Group by continent
order by TotalDeathCount desc

--2
SELECT location ,Max(cast(Total_deaths as int)) as TotalDeathCount
FROM CovidProject..CovidDeaths$
Where continent is null
Group by location
order by TotalDeathCount desc

--Global Numbers

SELECT Sum(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM CovidDeaths$
Where continent is not null
order by 1,2

--Looking Total Population vs Vaccinations
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
FROM CovidDeaths$ dea
Join CovidVaccinations$ vac
	On dea.location=vac.location
   and dea.date=vac.date
WHERE dea.continent is not null
order by 2,3;