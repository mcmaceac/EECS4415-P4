<continents>
{
	let $contData :=
		<data>
		{
			let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
			for $continents in distinct-values($doc//encompassed/@continent)
			order by $continents
			return
				<continent name="{$continents}">
				{
					for $country in $doc//country
					let $percentage := $country/encompassed[$continents=@continent]/@percentage
					order by $country/name
					where $country/encompassed/@continent = $continents
					return 
						<country name="{$country/name}" size="{xs:integer(round($country/@area * $percentage * .01))}">
						</country>
				}
				</continent>
		}
		</data>
		for $continent in $contData/continent
		return <continent name="{$continent/@name}" size="{xs:integer(sum($continent/country/@size))}" countries="{count($continent/country)}">
			{
				$continent/country
			}
		</continent>
}
</continents>