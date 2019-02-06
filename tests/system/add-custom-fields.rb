describe'system/add-custom-field' do
        request('/user/logout')
        Scripts.login($staff[:email], $staff[:password], true)

        it 'should fail if the name is to short ' do
            result = request('/system/add-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                name: 'A',
                type: 'text',
                description: 'custom field description',
                options: nil
            })

            (result['status']).should.equal('fail')
            (result['message']).should.equal('INVALID_NAME')

        end

        it 'should fail if the name is to long' do
            long_text = ''
            101.times {long_text << 'A'}

            result = request('/system/add-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                name: long_text,
                type: 'text',
                description: 'custom field description',
                options: nil
            })

            (result['status']).should.equal('fail')
            (result['message']).should.equal('INVALID_NAME')
        end

        it 'should fail if the type is not one of text or select'do
            result = request('/system/add-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                name: 'name of custom field',
                type: 'tex',
                description: 'custom field description',
                options: nil
            })

            (result['status']).should.equal('fail')
            (result['message']).should.equal('INVALID_CUSTOM_FIELD_TYPE')

            result = request('/system/add-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                name: 'name of custom field',
                type: 'selec',
                description: 'custom field description',
                options: nil
            })

            (result['status']).should.equal('fail')
            (result['message']).should.equal('INVALID_CUSTOM_FIELD_TYPE')
        end
        it 'should fail if the option is invalid' do

            result = request('/system/add-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                name: 'name of custom field',
                type: 'text',
                description: 'custom field description',
                options: 'json'
            })

            (result['status']).should.equal('fail')
            (result['message']).should.equal('INVALID_CUSTOM_FIELD_TYPE')

        end
        it 'should success if everything is ok' do
            result = request('/system/add-custom-field', {
                csrf_userid: $csrf_userid,
                csrf_token: $csrf_token,
                name: 'name of custom field',
                type: 'text',
                description: 'custom field description',
                options: { "key": "value" }
            })

            (result['status']).should.equal('success')

            row = $database.getRow('customfield', 1, 'id')
            
            (row['name']).should.equal('name of custom field')
            (row['type']).should.equal('text')
            (row['description']).should.equal('custom field description')
            (row['options']).should.equal({ "key": "value" })
        end


end
