<rivers>
{
	let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
	for $rivers in distinct-values($doc//located_at[@watertype="river"]/@river)
	let $river := tokenize($rivers, '\s')[1]
	let $riverName := replace($river, "river-", "")
	order by $riverName
	return <river name="{$riverName}">
	{
		for $country in $doc//country
		where $country//located_at[$river=@river]
		order by $country/name
		return <country name="{$country/name}">
		</country>
	}
	</river>
}
</rivers>