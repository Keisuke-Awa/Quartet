namespace :composing do
  desc "Build application images"
  task :build do
    on roles(:app) do
      within current_path do
        execute("docker-compose",
          # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
          # "-f", "docker-compose.#{fetch(:stage)}.yml",
          "build"
        )
      end
    end
  end

  desc "Take down compose application containers"
  task :down do
    on roles(:app) do
      within current_path do
        execute("docker-compose",
          # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
          # "-f", "docker-compose.#{fetch(:stage)}.yml",
          "down"
        )
      end
    end
  end

  namespace :restart do
    desc "Rebuild and restart web container"
    task :web do
      on roles(:app) do
        within current_path do
          execute("docker-compose",
            "down"
          )
          execute("docker-compose",
            # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
            # "-f", "docker-compose.#{fetch(:stage)}.yml",
            "build"
          )
          execute("docker-compose",
            # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
            # "-f", "docker-compose.#{fetch(:stage)}.yml",
            "up", "-d"
          )
          # execute("docker-compose",
          #   "run", "web", "bundle", "install"
          # )
          # execute("docker-compose",
          #   "run", "web", "rails", "db:migrate", "-e", "RAILS_ENV=production"
          # )
        end
      end
    end
  end

  namespace :database do
    desc "Up database and make sure it's ready"
    task :up do
      on roles(:app) do
        within current_path do
          execute("docker-compose",
            # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
            # "-f", "docker-compose.#{fetch(:stage)}.yml",
            "up", "-d"
          )
        end
      end
      sleep 5
    end

    desc "Create database"
    task :create do
      on roles(:app) do
        within current_path do
          execute("docker-compose",
            # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
            # "-f", "docker-compose.#{fetch(:stage)}.yml",
            "run", "--rm", "web", "rake", "db:create"
          )
        end
      end
    end

    desc "Migrate database"
    task :migrate do
      on roles(:app) do
        within current_path do
          execute("docker-compose",
            # "--project-name=#{fetch(:application)}_#{fetch(:stage)}",
            # "-f", "docker-compose.#{fetch(:stage)}.yml",
            "run", "--rm", "web", "rake", "db:migrate"
          )
        end
      end
    end
  end
end
