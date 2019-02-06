describe'system/get-custom-fields' do
        request('/user/logout')
        Scripts.login($staff[:email], $staff[:password], true)

        it 'should success and shows the whole custom fields' do
            Scripts.createCustomField('custom name','text','description number 1')
            Scripts.createCustomField('custom name2','text','description number 2')
            Scripts.createCustomField('custom name3','text','description number 3')
            result = request('/system/get-custom-fields', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token
            })

            (result['status']).should.equal('success')

            result['data'][0]['name'].should.equal('custom name')
            result['data'][0]['type'].should.equal('text')
            result['data'][0]['description'].should.equal('description number 1')
            result['data'][0]['options'].should.equal({ "key": "value" },{ "key": "value2" })
            result['data'][1]['name'].should.equal('custom name2')
            result['data'][1]['type'].should.equal('text')
            result['data'][1]['description'].should.equal('description number 2')
            result['data'][1]['options'].should.equal({ "key": "value" },{ "key": "value2" })
            result['data'][2]['name'].should.equal('custom name3')
            result['data'][2]['type'].should.equal('text')
            result['data'][2]['description'].should.equal('description number 3')
            result['data'][2]['options'].should.equal({ "key": "value" },{ "key": "value2" })


        end
end
