class helloworld {
        file { '/tmp/helloFromMaster':
                content => "See you at http://terokarvinen.com/tag/puppet\n"
        }
}
