(:
Generate a document that reports for each language, the countries that have a reported population that speaks that language. Report in an attribute speakers for <country> an estimate of the number of speakers of that language (as country's population times the percentage that speak that language).
:)
<languages>
{
	let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
	for $languages in distinct-values($doc//language)
	order by $languages
	return <language name="{$languages}">
	{
		for $country in $doc//country
		let $latestYear := max($country/population/@year)
		let $latestPop := $country/population[$latestYear=@year]
		let $speakers := round($country/language[$languages=text()]/@percentage * 0.01 * $latestPop)
		order by xs:integer($speakers) descending
		return if ($country/language/text() = $languages) then (
			<country name="{$country/name}" speakers="{xs:integer($speakers)}">
			</country>
		) else()
	}
	</language>
}
</languages>