<rivers>
{
	let $doc := doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")
	for $rivers in distinct-values($doc//located_at[@watertype="river"]/@river)
	let $river := replace($rivers, '^[^-]*-([^-]*).*$', '$1')
	order by $river
	return <river name="{$river}">
	{
		for $country in $doc//country
		where $country//located_at[$rivers=@river]
		order by $country/name
		return <country name="{$country/name}">
		</country>
	}
	</river>
}
</rivers>