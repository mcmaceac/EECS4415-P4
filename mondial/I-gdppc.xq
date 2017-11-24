<countries>
{
	let $countryData :=
		<data>
		{
			let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
			for $country in $doc//country
			let $recentYear := max($country/population/@year)
			let $population := $country/population[$recentYear=@year][1]
			let $government := 
				if ((fn:contains($country/government/text(), "democracy") or
						fn:contains($country/government/text(), "republic") or
						fn:contains($country/government/text(), "constitutional monarchy")) and
						not(fn:contains($country/government/text(), "dictator"))) then (
					"democracy"
				) else (
					"not-democracy"
				)
			where exists($country/gdp_total)
			return 
				<country gdp="{$country/gdp_total}" gvt="{$government}" pop="{$population}">
				</country>
		}
		</data>
		for $country in $countryData/country
		order by $country/@gvt
		return $country
}
</countries>