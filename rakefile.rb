#Create an artifact
task :hello,[:verno] do |t,args|
    begin
        sh 'go build hello.go'
        sh "powershell.exe Compress-Archive hello.exe Hello_#{args.verno}.zip"
        Rake::Task['remove'].execute
    rescue
        #puts 'Version Already exists try Updating artifact'
        sh 'powershell.exe Remove-Item hello.exe'
        Rake::Task['hello'].clear
        raise 'Version Already exists'
    end
end

#Remove exe
task :remove do
    sh 'powershell.exe Remove-Item hello.exe'
    Rake::Task['hello'].clear
    Rake::Task['remove'].clear
end

#Update an artifact
task :update,[:verno] do |t,arg|
    sh 'g++ Prasanth/Helloworld.cpp -o hello'
    sh "powershell.exe Compress-Archive -Update hello.exe Hello_#{arg.verno}.zip"
    Rake::Task['remove'].execute
end