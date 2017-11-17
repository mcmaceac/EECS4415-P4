(:
For a country's name, report the country's name, not its country code.
For attribute percentage, report the percentage of the population of that country which is buddhist.
Within root <buddhist>, present the <country> list in document order.
:)
<buddhist>
{
	for $country in doc("http://www.eecs.yorku.ca/course_archive/2017-18/F/4415/project/mondial/dataset/mondial-2015.xml")/mondial/country[religion/text() = "Buddhist"]
	return <country name="{$country/name}" percentage="{$country/religion[text() = "Buddhist"]/@percentage}"/>
}
</buddhist>