describe'system/delete-custom-field' do
        request('/user/logout')
        Scripts.login($staff[:email], $staff[:password], true)

        it 'should fail if is an invalid custom field ' do
            result = request('/system/delete-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                id: 100
            })

            (result['status']).should.equal('fail')
            (result['message']).should.equal('INVALID_CUSTOM_FIELD')

        end
        it 'should success if everything is ok' do
            result = request('/system/delete-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                id:1
            })

            (result['status']).should.equal('success')

            row = $database.getRow('customfield', 1, 'id')

            (row).should.equal(nil)

        end
end
