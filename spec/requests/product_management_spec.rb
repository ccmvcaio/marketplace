describe 'Product management' do
  context 'index' do
    it 'renders available products' do
      profile = create(:profile)
      create(:product, name: 'Chinelo', category: 'Vestuário', profile: profile)
      create(:product, name: 'Panela', category: 'Cozinha', profile: profile)
      create(:product, name: 'Pneu', category: 'Automóveis', profile: profile)

      get '/api/v1/products'

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[0][:name]).to eq('Chinelo')
      expect(body[0][:category]).to eq('Vestuário')
      expect(body[1][:name]).to eq('Panela')
      expect(body[1][:category]).to eq('Cozinha')
      expect(body[2][:name]).to eq('Pneu')
      expect(body[2][:category]).to eq('Automóveis')
    end

    it 'renders empty json' do
      get '/api/v1/products'

      response_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(response_json).to be_empty
      expect(response.content_type).to include('application/json')
    end
  end

  context 'GET api/v1/product/:id' do
    context 'record exists' do
      let(:product) do
        create(:product, name: 'Chinelo', category: 'Vestuário')
      end

      it 'return status 200' do
        get "/api/v1/products/#{product.id}"

        expect(response).to be_ok
      end

      it 'returns product' do
        get "/api/v1/products/#{product.id}"

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response_json[:name]).to eq('Chinelo')
        expect(response_json[:category]).to eq('Vestuário')
      end
    end

    context 'record not exist' do
      it 'return status 404' do
        get '/api/v1/products/000'

        expect(response).to be_not_found
      end

      it 'return not found message' do
        get '/api/v1/products/00'

        expect(response.body).to include('Produto não encontrado')
      end
    end
  end

  context 'POST /api/v1/products' do
    context 'with valid parameters' do
      let(:profile) { create(:profile) }
      let(:attributes) { attributes_for(:product, profile_id: profile.id) }

      it 'returns 201 status' do
        post '/api/v1/products', params: { product: attributes }

        expect(response).to be_created
      end

      it  'return created product' do
        post '/api/v1/products', params: { product: attributes }

        product = JSON.parse(response.body, symbolize_names: true)
        expect(product[:id]).to be_present
        expect(product[:name]).to eq(attributes[:name])
        expect(product[:category]).to eq(attributes[:category])
        expect(product[:description]).to eq(attributes[:description])
        expect(product[:price]).to eq(attributes[:price])
      end

      context 'with invalid params' do
        it 'without requested params' do
          post '/api/v1/products', params: { product: { foo: 'bar' } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include('Perfil é obrigatório(a)')
          expect(response.body).to include('Nome não pode ficar em branco')
          expect(response.body).to include('Descrição não pode ficar em branco')
          expect(response.body).to include('Categoria não pode ficar em branco')
          expect(response.body).to include('Preço não pode ficar em branco')
        end

        it 'without product key' do
          post '/api/v1/products'

          expect(response).to have_http_status(:precondition_failed)
          expect(response.body).to include('Parâmetros inválidos')
        end
      end
    end
  end
end