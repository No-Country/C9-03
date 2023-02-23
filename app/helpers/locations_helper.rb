module LocationsHelper
    def html_link_to_location(location)
      link_to location.name,
              location_url(location),
              target: '_blank',
              style: 'font-weight: bold; color: green'
    end
  end