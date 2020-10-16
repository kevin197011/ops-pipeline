# frozen_string_literal: true

require 'rubysdk'
# require 'shell'

class Main
  CreateUser = lambda do |_args|
    warn 'CreateUser has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)

    # scripts =<<-SHELL.strip_heredoc
    #    touch /tmp/a{1..5}.txt
    #    ls /tmp/*
    # SHELL

    warn %x[
      yum install ansible -y;
      rm -rf /tmp/*;
      touch /tmp/a{1..5}.txt;
      ls /tmp/*;
      ansible --version;
    ]
    # warn `#{scripts}`
    # sh = Shell.new
    # warn sh.pwd
    # warn sh.ls '/tmp'

    warn 'CreateUser has been finished!'
  end

  MigrateDB = lambda do |_args|
    warn 'MigrateDB has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)
    warn 'MigrateDB has been finished!'
  end

  CreateNamespace = lambda do |_args|
    warn 'CreateNamespace has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)
    warn 'CreateNamespace has been finished!'
  end

  CreateDeployment = lambda do |_args|
    warn 'CreateDeployment has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)
    warn 'CreateDeployment has been finished!'
  end

  CreateService = lambda do |_args|
    warn 'CreateService has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)
    warn 'CreateService has been finished!'
  end

  CreateIngress = lambda do |_args|
    warn 'CreateIngress has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)
    warn 'CreateIngress has been finished!'
  end

  Cleanup = lambda do |_args|
    warn 'Cleanup has been started!'
    # lets sleep to simulate that we do something.
    sleep(2.0)
    warn 'Cleanup has been finished!'
  end

  def self.main
    createuser = Interface::Job.new(title: 'Create DB User',
                                    desc: 'Create DB User with least privileged permissions.',
                                    handler: CreateUser)

    migratedb = Interface::Job.new(title: 'DB Migration',
                                   handler: MigrateDB,
                                   desc: 'Imports newest test data dump and migrates to newest version.',
                                   dependson: ['Create DB User'])

    createnamespace = Interface::Job.new(title: 'Create K8S Namespace',
                                         handler: CreateNamespace,
                                         desc: 'Create a new Kubernetes namespace for the new test environment.',
                                         dependson: ['DB Migration'])

    createdeployment = Interface::Job.new(title: 'Create K8S Deployment',
                                          handler: CreateDeployment,
                                          desc: 'Create a new Kubernetes deployment for the new test environment.',
                                          dependson: ['Create K8S Namespace'])

    createservice = Interface::Job.new(title: 'Create K8S Service',
                                       handler: CreateService,
                                       desc: 'Create a new Kubernetes service for the new test environment.',
                                       dependson: ['Create K8S Namespace'])

    createingress = Interface::Job.new(title: 'Create K8S Ingress',
                                       handler: CreateIngress,
                                       desc: 'Create a new Kubernetes ingress for the new test environment.',
                                       dependson: ['Create K8S Namespace'])

    cleanup = Interface::Job.new(title: 'Clean up',
                                 handler: Cleanup,
                                 desc: 'Removes all temporary files.',
                                 dependson: ['Create K8S Deployment', 'Create K8S Service', 'Create K8S Ingress'])

    begin
      RubySDK.Serve([createuser, migratedb, createnamespace, createdeployment, createservice, createingress, cleanup])
    rescue StandardError => e
      puts "Error occured: #{e}"
      exit(false)
    end
  end
end
