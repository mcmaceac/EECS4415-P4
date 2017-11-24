(:
For each country, report its name, capital, population, and size. Report every country; if one of the requested pieces of information for the country is missing, just leave it out.

For name, report the country's name, not its country code.
For capital, report the city's name, not the document's string for it. E.g., France's capital should be reported as “Paris”, not as “cty-France-Paris”. If there is more than one name for the city provided, choose the first.
For population, report the population count of the most recent (latest) year reported. Show the year in the results as an attribute. (Only have that one attribute, no more!)
Note that all <population> nodes in the dataset have a year attribute. You may assume this.
Size is reported as attribute area in the document.
For the inception data, use the value of the node <indep_date> under <country>.
If a country has no indep_date reported, do _not include <inception> for that country in the results.
Within root <summary>, sort the <country> list by name.
:)
<summary>
{
	let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
	for $country in $doc/mondial/country
	let $capCode := $country/@capital
	let $latestYear := max($country/population/@year)
	let $latestPop := data($country/population[$latestYear=@year])
	let $inception := data($country/indep_date)
	order by $country/name
	return
		<country name="{$country/name}">
			<capital>{$country//city[$capCode=@id]/name[1]/text()}</capital>
			<population year="{$latestYear}">{$latestPop}</population>
			<size>{data($country/@area)}</size>
			{if (exists($inception)) then (
			<inception>{$inception}</inception>
			) else()}
		</country>
}
</summary>