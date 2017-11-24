(:
For each country, list the countries that border it by name. Place within the bordering <neighbour> a node <length> that contains the length of the shared border.
:)
<countries>
{
	let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
	for $country in $doc//country
	order by $country/name
	return if (exists($country/border)) then (<country name="{$country/name/text()}">
	{
		for $neighbours in $country/border
		let $neigh_code := data($neighbours/@country)
		let $countries := $doc//country
		let $neigh_name := $countries[$neigh_code=@car_code]/name
		order by $neigh_name
		return 
		<neighbour name="{$neigh_name}">
			<length>{data($neighbours/@length)}</length>
		</neighbour>
	}
	</country>) else()
}
</countries>