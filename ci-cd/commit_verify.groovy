@Library('uvci@master') _

    def build_info = [:]
node('BackendBuildMachine'){
    stage('Run build from ci_jobs repo') {
        def scmvars = checkout scm 
        build_info.gitCommit = scmvars.GIT_COMMIT
        def pack_info = readJSON file: 'package.json'
        build_info.service_name = pack_info.name
        bitbucketStatusNotify(repoSlug: build_info.service_name, commitId: build_info.gitCommit, buildState: 'INPROGRESS')
        echo "commit after scmvars ${build_info.gitCommit}"
        try {
            echo "start building "
            be_build_commit(build_info)
        } catch (Exception e) {
        bitbucketStatusNotify(repoSlug: build_info.service_name, commitId: build_info.gitCommit, buildState: 'FAILED')
        error("Build ${build_info.service_name} failed")
        }
        bitbucketStatusNotify(repoSlug: build_info.service_name, commitId: build_info.gitCommit, buildState: 'SUCCESSFUL') 
    }                                               
}
