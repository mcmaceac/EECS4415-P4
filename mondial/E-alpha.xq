(:
For each country, report the alpha city for that country; that is, the city in the country with the largest population.

Use the country's name, not country code.
In many cases, several populations are reported for a city, as measured in different years; use the latest year's population.
If a city has no population reported, ignore it.
In the dataset, when a <population> node is present for a city, it has a year attribute. You may assume this.
Within root <cities>, sort the <country> list by country name.
In the extremely rare case a country has more than one largest city (that is, with the exact same reported population for each), report each, ordered by the cities' names.
:)

<alpha> {
let $alpha :=
	<alpha>
	{
		let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
		for $country in $doc/mondial/country
		order by $country/name
		return <country name="{$country/name/text()}">
		{
			for $city in $country//city
			let $latestYear := max($city/population/@year)
			let $latestPop := $city/population[@year=$latestYear]
			return if (exists($latestYear)) then (<city name="{$city/name[1]/text()}" year="{$latestYear}" pop="{$latestPop}">
			</city>) else()
		}
		</country>
	}
	</alpha>

	for $countries in $alpha/country
	let $maxPop := max($countries/city/@pop)
	where exists($maxPop)
	return <country name="{$countries/@name}">
	{
		for $cities in $countries/city[@pop=$maxPop]
		return <alpha name="{$cities/@name}" population="{xs:integer($maxPop)}">
		</alpha>
	}
	</country>
}</alpha>

