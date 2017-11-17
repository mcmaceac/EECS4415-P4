(:
Report countries that straddle two (or more) continents. 
Include as content which continents the country occupies.

Within root <straddle>, present the <country> list in document order.
Within node <country>, present the <continent> node in document order 
(as they appear within that <country> node within the document).
:)
<straddle>
{
	for $country in doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")/mondial/country
	where count($country/encompassed) > 1
	return <country name="{$country/name}">
	{
		for $continent in $country/encompassed
		return <continent name="{$continent/@continent}"/>
	}
	</country>
}
</straddle>