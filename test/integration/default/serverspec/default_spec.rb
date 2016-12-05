require 'spec_helper'

elasticsearch_curator_conf_dir = '/etc/elasticsearch-curator'
elasticsearch_curator_cmd = "curator --config #{elasticsearch_curator_conf_dir}/curator.yml #{elasticsearch_curator_conf_dir}/actions.yml"

describe package('elasticsearch-curator') do
  it { should be_installed.by('pip') }
end

describe file(elasticsearch_curator_conf_dir) do
  it { should be_directory }
  it { should be_owned_by 'root' }
end

%W(
  #{elasticsearch_curator_conf_dir}/curator.yml
  #{elasticsearch_curator_conf_dir}/actions.yml
).each do |f|
  describe file(f) do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
  end
end

describe command(elasticsearch_curator_cmd) do
  its(:exit_status) { should eq 0 }
end
