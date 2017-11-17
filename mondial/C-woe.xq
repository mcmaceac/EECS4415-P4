(:
Report countries that have more than 5% inflation and 10% unemployment.
Within root <woe>, present the <country> list in document order.
:)
<woe>
{
	for $country in doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")/mondial/country
	where data($country/inflation) > 5 and data($country/unemployment) > 10
	return <country name="{$country/name}">
		<inflation>{data($country/inflation)}</inflation>
		<unemployment>{data($country/unemployment)}</unemployment>
	</country>
}
</woe> 