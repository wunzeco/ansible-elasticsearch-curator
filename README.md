elasticsearch-curator
=====================

Ansible role to install and configure elasticsearch-curator.


## Examples

```
- hosts: eshost

  vars:
    elasticsearch_curator_version: 4.2.3
    elasticsearch_curator_client_hosts: localhost
    elasticsearch_curator_actions:
      - action: delete_indices
        description: >-
          Delete indices older than 45 days (based on index name), for logstash-
          prefixed indices. Ignore the error if the filter does not result in an
          actionable list of indices (ignore_empty_list) and exit cleanly.
        options:
          ignore_empty_list: True
          timeout_override:
          continue_if_exception: False
          disable_action: True
        filters:
          - filtertype: pattern
            kind: prefix
            value: logstash-
            exclude:
          - filtertype: age
            source: name
            direction: older
            timestring: "'%Y.%m.%d'"
            unit: days
            unit_count: 45
            exclude:
    elasticsearch_curator_cron_job:
      description: "Curate Elasticsearch Indices once per week"
      minute:  0
      hour:    0
      day:     '*'
      weekday: 6
      month:   '*'

  roles:
    - wunzeco.elasticsearch_curator
```

## Testing

To test this role, run

```
kitchen test
```


## Dependencies:

None
