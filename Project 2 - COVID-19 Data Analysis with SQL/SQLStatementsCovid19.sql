-- Just browsing through the data for what I might be using
SELECT *
FROM coviddeaths
ORDER BY 3, 4;

-- Just browsing through the data for what I might be using
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
ORDER BY location, new_cases;

-- Just browsing through the data for what I might be using
SELECT * 
FROM coviddeaths
WHERE continent LIKE 'europe' AND location LIKE 'netherlands';

-- Calculating the death percentage in netherlands
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE location LIKE 'netherlands'
ORDER BY location, DeathPercentage DESC;

-- Looking at highest infection rate compared to population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM coviddeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;

-- Highest death count per population per country
SELECT Location, MAX(cast(Total_deaths as unsigned)) AS TotalDeathCount
FROM coviddeaths
GROUP BY Location
ORDER BY TotalDeathCount DESC;
-- The query couldn't properly read the total deaths, the death counts were way too low
-- So I added 'cast as unsigned' to properly add the numeric integers to the calculation, and it fixed

-- Checking total death count in the Netherlands from covid19
SELECT Location, MAX(cast(Total_deaths as unsigned)) AS TotalDeathCount
FROM coviddeaths
WHERE Location like 'netherlands'
GROUP BY Location
ORDER BY TotalDeathCount DESC;
-- It says 17.3k deaths, which isn't accurate. But that's because I don't have all the data.

-- Checking what I'm working with inside covidvaccinations table
SELECT *
FROM covidvaccinations
WHERE continent like 'asia';

-- Bringing both tables together, and seeing how many total tests are made in Asia
SELECT dea.continent, dea.location, dea.date, dea.population, vac.total_tests
FROM coviddeaths AS dea
JOIN covidvaccinations AS vac 
    ON dea.location = vac.location 
    AND dea.date = vac.date 
WHERE dea.continent LIKE 'asia' 
ORDER BY vac.total_tests DESC;
